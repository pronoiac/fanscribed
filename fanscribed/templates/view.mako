<%inherit file="base.mako" />

<%def name="head_title()">Transcript</%def>

<%def name="body_class()">view</%def>

<%def name="player_update_interval()">500</%def>

<%def name="head_script()">
  <script type="text/javascript">
    view_init();
    $(view_onload);
  </script>
</%def>

<%def name="toolbar()">
  <strong>View</strong>
  |
  <a href="${request.route_path('edit')}">Transcribe</a>
</%def>

<%def name="sidebar_top()">
    <div id="links">
      <%
      links = transcription_info.get('links', [])
      %>
      % if links:
          <h2>Links</h2>
          <ul>
            % for link_info in transcription_info.get('links', []):
                <li><a href="${link_info['url']}">${link_info['title']}</a></li>
            % endfor
          </ul>
      % endif
    </div>
</%def>

<%def name="sidebar()">
</%def>

<%def name="body()">
  <h2>Transcript</h2>

  % for starting_point, lines in snippets:
      <%
      last_speaker = None
      starting_seconds = starting_point / 1000
      starting_minutes = starting_seconds / 60
      starting_seconds = starting_seconds % 60
      anchor = '{0:d}m{1:02d}s'.format(starting_minutes, starting_seconds)
      anchor_label = '{0:d}:{1:02d}'.format(starting_minutes, starting_seconds)
      %>
      % if lines:
          <p class="timestamp"><a id="${anchor}" href="#${anchor}">${anchor_label} (permalink)</a> - <a href="javascript:player_play_from(${starting_point})">Begin playback here</a></p>
          <dl class="transcript">
            % for speaker, spoken in lines:
                % if speaker and last_speaker != speaker:
                    <dt>${speaker}:</dt>
                    <dd>${spoken}</dd>
                % else:
                    <dd>${spoken}</dd>
                % endif
                <%
                    last_speaker = speaker
                %>
            % endfor
          </dl>
      % else:
          <p class="timestamp"><a id="${anchor}" href="#${anchor}">${anchor_label} (permalink)</a> - <a href="javascript:player_play_from(${starting_point})">Begin playback here</a> - <a href="${request.route_path('edit')}">Help transcribe</a></p>
      % endif
  % endfor
</%def>
