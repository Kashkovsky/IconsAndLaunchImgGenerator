on run
	
	try
		tell application "Finder"
			activate
			set fileOriginal to (choose file with prompt "Please choose the original image file:" without multiple selections allowed) as string
			set folderIconFiles to (choose folder with prompt "Please choose the folder to save the newly created icon-images into:" without multiple selections allowed) as string
		end tell
		
		(* App icon (required for all apps) *)
		
		(* iPhone 6s Plus and iPhone 6 Plus *)
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 180, 3, "x.png")
		(* iPhone 6s, iPhone 6, and iPhone 5 *)
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 120, 2, "x.png")
		(* iPad and iPad mini *)
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 152, 2, "x.png")
		(* iPad, iPad 2 and iPad mini *)
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 76, 1, ".png")
		(* iPad Pro *)
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 167, 2, "x.png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 57, 1, ".png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 114, 2, "x.png")
		
		
		
		(* App icon for the App Store (required for all apps) *)
		
		(* iPhone 6s Plus and iPhone 6 Plus *)
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 1024, 3, "x.png")
		(* iPhone 6s, iPhone 6, and iPhone 5 *)
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 1024, 2, "x.png")
		(* iPad, iPad 2 and iPad mini *)
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 1024, 1, ".png")
		
		(* Spotlight search results icon (recommended) *)
		
		(* iPhone 6s Plus and iPhone 6 Plus *)
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 120, 3, "x.png")
		(* iPhone 5 *)
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 80, 2, "x.png")
		(* iPad, iPad 2 and iPad mini *)
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 60, 1, ".png")
		
		(* Settings icon (recommended) *)
		
		(* iPhone 6s Plus and iPhone 6 Plus *)
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 87, 3, "x.png")
		(* iPhone 6s, iPhone 6, and iPhone 5 *)
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 58, 2, "x.png")
		(* iPad, iPad 2 and iPad mini *)
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 29, 1, ".png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 40, 1, ".png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 50, 1, ".png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 100, 2, "x.png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 72, 1, ".png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 48, 2, "x.png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 55, 2, "x.png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 87, 3, "x.png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 80, 1, ".png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 88, 2, "x.png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 172, 2, "x.png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 196, 2, "x.png")
		
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 16, 1, ".png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 32, 2, "x.png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 32, 1, ".png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 64, 2, "x.png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 128, 1, ".png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 256, 2, "x.png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 256, 1, ".png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 512, 2, "x.png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 512, 1, ".png")
		tell me to resizeAndSave(fileOriginal, folderIconFiles, 144, 2, "x.png")
		
	on error (e)
		log "Error: " & e
	end try
	
end run


on resizeAndSave(originalFilePath, folderPath, sizex, factor, suffix)
	
	if (factor as integer) = 1 then
		set newFileName to "icon_" & (sizex as text) & "x" & (sizex as text) & suffix
	else if (factor as integer) > 1 then
		set newFileName to "icon_" & (sizex as text) & "x" & (sizex as text) & "@" & factor & suffix
	else
		display dialog "Invalid factor." buttons {"WTF?"}
		return
	end if
	set filePath to folderPath & newFileName
	tell application "Image Events"
		set originalImg to open originalFilePath
		copy dimensions of originalImg to {W, H}
		if W is less than H then
			set the scale_length to (H * sizex) / W
			set the scale_length to ¬
				round scale_length rounding as taught in school
		else
			set the scale_length to (W * sizex) / H
			set the scale_length to ¬
				round scale_length rounding as taught in school
		end if
		
		scale originalImg to size scale_length
		crop originalImg to dimensions {sizex, sizex}
		set the new_image to save originalImg as PNG in file filePath with icon
		close originalImg
	end tell
	
end resizeAndSave
