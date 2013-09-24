import Network.HTTP  
import Text.HTML.TagSoup  
  
openURL :: String -> IO String  
openURL x = getResponseBody =<< simpleHTTP (getRequest x)  
  
hrefs :: IO [String]  
hrefs = do  
    tags <- fmap parseTags $ openURL "http://localhost"  
    let attrs = [head i | (TagOpen "a" i) <- tags]  
    return [j | ("href", j) <- attrs]