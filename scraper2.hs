import Control.Applicative ((<$>))
import Data.Maybe (fromJust)
import Network.Browser
import Network.HTTP
--import Network.HTTP.Conduit
import Network.HTTP.Proxy (parseProxy)

main = do
  rsp <- browse $ do
    --setAuthorityGen (arieger, winurere79)
    --setProxy . fromJust $ parseProxy "10.10.10.10:8080"
    --applyBasicAuth arieger winurere79 $ fromJust $ parseUrl "http://www.google.com"
    request $ getRequest "http://127.0.0.1"
  print $ rspBody <$> rsp