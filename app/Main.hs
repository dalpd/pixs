{-# LANGUAGE UnicodeSyntax #-}

import Prelude hiding (flip, error)
import System.Environment (getArgs)
import Codec.Picture (readImage, writePng, DynamicImage(..))
import qualified Pixs.Transformation as T

main ∷ IO ()
main = do
  -- TODO: There is probably a much better way of
  -- doing argument parsing here.
  args           <- getArgs
  imageLoad      <- readImage (args !! 1)
  case imageLoad of
    Left  error → putStrLn error
    Right image →
      case image of
          ImageRGBA8 img →
            case args of
              ["brightness",_,amount,outFile]
                → writePng outFile
                    $ T.changeBrightness (read amount) img
              ["red",_,amount,outFile]
                → writePng outFile
                    $ T.changeRed (read amount) img
              ["green",_,amount,outFile]
                → writePng outFile
                    $ T.changeGreen (read amount) img
              ["flipVertical",_,outFile]
                → writePng outFile
                    $ T.flipVertical img
              ["flipHorizontal",_,outFile]
                → writePng outFile
                    $ T.flipHorizontal img
              -- ["flip",_,outFile]
                -- → writePng outFile
                   -- $ T.flip img
              ["blur",_,outFile]
                → writePng outFile
                    $ T.blur img 5
              _ → putStrLn "Please enter valid arguments."
          ImageRGB8 img →
            case args of
              ["flip",_,outFile]
                → writePng outFile
                   $ T.flip img
              ["flipHorizontal",_,outFile]
                → writePng outFile
                   $ T.flipHorizontal img
              ["flipVertical",_,outFile]
                → writePng outFile
                   $ T.flipVertical img
              _ → putStrLn "Please enter valid arguments."
          ImageY8 _ → putStrLn "Type not handled yet."
          ImageY16 _ → putStrLn "Type not handled yet."
          ImageYF _ → putStrLn "Type not handled yet."
          ImageYA8 _ → putStrLn "Type not handled yet."
          ImageYA16 _ → putStrLn "Type not handled yet."
          ImageRGBA16 _ → putStrLn "Type not handled yet."
          ImageRGBF _ → putStrLn "Type not handled yet."
          ImageRGB16 _ → putStrLn "Type not handled yet."
          ImageYCbCr8 _ → putStrLn "Type not handled yet."
          ImageCMYK8 _ → putStrLn "Type not handled yet."
          ImageCMYK16 _ → putStrLn "Type not handled yet."