import System.IO

handleSplittedLine :: [String] -> String
handleSplittedLine [] = ""
handleSplittedLine [header] = "\n    <th>" ++ header ++ "</th>"
handleSplittedLine parts
  | length parts > 2 =
      "\n    <td>"
        ++ head parts
        ++ "</td>\n    <td>"
        ++ foldl1 (\a b -> a ++ "," ++ b) (tail (init parts))
        ++ "</td>\n    <td>"
        ++ last parts
        ++ "</td>"

split :: String -> [String]
split s = case dropWhile (== ',') s of
  "" -> []
  s' -> w : split s''
    where
      (w, s'') = break (== ',') s'

handleLine :: String -> String
handleLine line = "  <tr>" ++ filter (/= '"') (handleSplittedLine (split line)) ++ "\n  </tr>"

handleFile :: String -> String
handleFile input = unlines $ map handleLine $ filter (/= ",,") $ lines input

main = do
  -- those excel files have carriage returns
  hSetNewlineMode stdin universalNewlineMode

  contents <- getContents
  putStrLn "<table>"
  putStr $ handleFile contents
  putStrLn "</table>"
