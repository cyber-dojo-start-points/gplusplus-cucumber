LANG=c

if  make --always-make 2>&1 ; then
  # Test output can be formatted as progress or documentation
  sleep 1
  cucumber --publish-quiet -f progress . -r .
fi
