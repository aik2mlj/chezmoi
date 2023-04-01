function sshmbz --wraps='sshpass -f ~/.ssh/mbz_ps ssh' --description 'alias sshmbz=sshpass -f ~/.ssh/mbz_ps ssh'
  sshpass -f ~/.ssh/mbz_ps ssh $argv; 
end
