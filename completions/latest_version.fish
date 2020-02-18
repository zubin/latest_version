complete -c latest_version -x -a '(__fish_latest_version_completion)'

function __fish_latest_version_completion
  set cmd (commandline -opc)
  switch (count $cmd)
    case 1
      latest_version --help |awk '/^  [a-z]/ {print $2}'
    case 2
      if [ $cmd[2] = 'completion' ]
        latest_version completions
      end
  end
end

abbr --add lv latest_version
