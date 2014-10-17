export PS1='\[\033[01;34m\]\w\[\033[00m\] \[\033[01;32m\]$ \[\033[00m\]'

if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi

if [ -d /app/.profile.d ]; then
  for i in /app/.profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi
