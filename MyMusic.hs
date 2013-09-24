import System.Cmd
import System.Directory

load RunProcess.hs
runIO $ "ls /etc" -|- "grep 'm.*ap'" -|- "tr a-z A-Z"



rawSystem "ls" ["-l", "/home/marten/projects"]
getDirectoryContents "/" >>= return . filter (`notElem` [".", ".."])
getModificationTime "/etc/passwd"

