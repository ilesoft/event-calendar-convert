import Data.List
import System.IO

handleSplittedLine :: [String] -> String
handleSplittedLine [] = ""
handleSplittedLine [header] = "    <th>" ++ header ++ "</th>"
handleSplittedLine [date, happening, organizer, audience] =
  "    <td>"
    ++ date
    ++ "</td>\n    <td>"
    ++ happening
    ++ "</td>\n    <td>"
    ++ organizer
    ++ "</td>\n    <td>"
    ++ audience
    ++ "</td>\n"
handleSplittedLine [a, b, c, d, inCharge] =
  (handleSplittedLine [a, b, c, d])
    ++ "    <td>"
    ++ inCharge
    ++ "</td>"

stripTabs :: String -> String
stripTabs s = dropWhileEnd (== '\t') s

split :: String -> [String]
split s = case dropWhile (== '\t') s of
  "" -> []
  s' -> w : split s''
    where
      (w, s'') = break (== '\t') s'

handleLine :: String -> String
handleLine "" = ""
handleLine line = "  <tr>\n" ++ handleSplittedLine (split line) ++ "\n  </tr>"

handleFile :: String -> String
handleFile input = unlines $ filter (/= "") $ map handleLine $ map stripTabs $ lines input

main = do
  -- those excel files have carriage returns
  hSetNewlineMode stdin universalNewlineMode

  contents <- getContents
  putStrLn "<table>"
  putStrLn "  <tr><th>Ajankohta</th><th>Tapahtuma</th><th>Järjestäjä</th><th>Kenelle</th><th>Vastuu/lisätietoja</th></tr>"
  putStr $ handleFile contents
  putStrLn "</table>"
