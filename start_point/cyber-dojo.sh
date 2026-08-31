LANG=c

# The makefile starts the compiled step-definitions as a wire server in the
# background, and cucumber talks to it over the port named in cucumber.wire.
# Waiting for that socket to reach LISTEN, rather than for a fixed second, is
# what lets the run finish as soon as the server is up.
#
# The wait must not itself connect. The server serves one session, so a probing
# connection would consume the one cucumber needs. A listening socket appears in
# /proc/net/tcp with its port in hex and state 0A, which reads the kernel's view
# without touching the server.
function wire_server_listening()
{
  local -r wire_file=features/step_definitions/cucumber.wire
  local -r port="$(awk '/^port:/ { print $2 }' "${wire_file}")"
  local -r hex_port="$(printf '%04X' "${port}")"
  grep -qE ":${hex_port} .* 0A " /proc/net/tcp /proc/net/tcp6 2> /dev/null
}

# Gives up after two seconds and lets cucumber report the connection failure
# itself, rather than sitting here until the runner's timeout.
function wait_until_wire_server_listening()
{
  local tries=0
  while ! wire_server_listening; do
    tries=$((tries + 1))
    if [ "${tries}" -gt 200 ]; then
      echo 'The step-definitions wire server is not listening'
      return
    fi
    sleep 0.01
  done
}

if  make --always-make 2>&1 ; then
  # Test output can be formatted as progress or documentation
  wait_until_wire_server_listening
  cucumber --publish-quiet -f progress . -r .
fi
