{-# LANGUAGE ScopedTypeVariables #-}

import Control.Exception
import Control.Monad
import System.Environment
import System.IO

main = do
	[out] <- getArgs
	s     <- getContents
	-- TODO: only catch the exception when it's because the file doesn't exist
	catch (update out s) (\(_ :: IOException) -> writeFile out s)

update out s = do
	h  <- openFile out ReadMode
	s' <- hGetContents h
	let write = s /= s'
	write `seq` hClose h
	when write (writeFile out s)
