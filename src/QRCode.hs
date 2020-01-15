{-# LANGUAGE DuplicateRecordFields, NamedFieldPuns #-}
module QRCode where

import qualified Data.UUID.V4 as UUIDV4
import qualified Data.UUID as UUID
import Data.Maybe (fromMaybe)
import qualified Codec.QRCode as QR
import Codec.QRCode.JuicyPixels (toImage)
import Codec.Picture.Types ( Image, Pixel8 )
import AsciiArt (printAsciiArtString)
import GHC.Generics (Generic)

data QrCode = QrCode {
    uuid  :: UUID.UUID
   , image :: Image Pixel8
}

instance Show QrCode where
  show (QrCode u i) = printAsciiArtString i

qrCode :: IO QrCode
qrCode = do
  uuid <- UUIDV4.nextRandom
  return $ QrCode uuid (createImage (UUID.toString uuid))

 
-- generate :: IO ()
-- generate = do
--   uuid <- UUIDV4.nextRandom
--   qrCode2 (UUID.toString uuid)

createImage :: String -> Image Pixel8
createImage input = toImage 1 1 
                    $ fromMaybe (error "QRC.encodeTExt failed") 
                    $ QR.encodeText (QR.defaultQRCodeOptions QR.M) QR.Utf8WithECI input