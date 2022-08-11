function lt --wraps='ll -T' --description 'tree view with custom level'
  if test -n "$argv"
      ll -T --level=$argv
  else
      ll -T --level=2
  end
end
