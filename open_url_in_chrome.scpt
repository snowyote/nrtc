on run argv
  tell application "Google Chrome"
    set aWin to make new window with properties {mode:"incognito"}
    tell aWin
      tell active tab to set URL to item 1 of argv
    end
  end
end run
