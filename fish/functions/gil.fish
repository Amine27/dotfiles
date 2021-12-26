function gil
    git log --graph --all --date='format:%Y-%m-%d %H:%M:%S' --pretty='format:%C(yellow)%h %C(green)%ad %C(bold blue)%an %C(auto)%d%C(reset) %s' $argv
end
