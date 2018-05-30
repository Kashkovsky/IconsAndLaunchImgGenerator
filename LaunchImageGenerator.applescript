on run
	try
		tell application "Finder"
			activate
			set fileOriginal to (choose file with prompt "Choose original image" without multiple selections allowed and invisibles) as string
			set destinationPath to (choose folder with prompt "Choose destination folder" without multiple selections allowed and invisibles) as string
		end tell
		
		tell me to createLaunchImage(fileOriginal, destinationPath, 1920, 1080, 1, "x.png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 1242, 2208, 1, "retina_HD55.png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 750, 1334, 1, "retina_HD47.png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 2208, 1242, 1, "retina_HD55.png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 640, 960, 2, "x.png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 640, 1136, 1, "retina_4.png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 768, 1024, 1, ".png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 1536, 2048, 2, "x.png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 1024, 768, 1, ".png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 2048, 1536, 2, "x.png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 320, 480, 1, ".png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 640, 960, 2, "x.png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 640, 1136, 1, "retina_4.png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 768, 1004, 1, ".png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 1536, 2008, 2, "x.png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 1024, 768, 1, ".png")
		tell me to createLaunchImage(fileOriginal, destinationPath, 2048, 1496, 2, "x.png")
		
	on error (e)
		log "Error: " & e
	end try
	
end run

on createLaunchImage(originalFilePath, folderPath, sizex, sizey, factor, suffix)
	if (factor as integer) = 1 then
		set newFileName to "launchImage_" & (sizex as text) & "x" & (sizey as text) & suffix
	else if (factor as integer) > 1 then
		set newFileName to "launchImage_" & (sizex as text) & "x" & (sizey as text) & "@" & factor & suffix
	else
		display dialog "Invalid factor." buttons {"WTF?"}
		return
	end if
	
	set filePath to folderPath & newFileName
	
	try
		tell application "Image Events"
			launch
			set originalImg to open originalFilePath
			copy dimensions of originalImg to {W, H}
			
			if sizey is greater than sizex then
				if W is greater than H then
					rotate originalImg to angle 270
					copy dimensions of originalImg to {W, H}
					set the new_H to (W * sizey) / sizex
					set crop_dimensions to {W, new_H}
				else
					set the new_W to (H * sizex) / sizey
					set crop_dimensions to {new_W, H}
				end if
			else
				if H is greater than W then
					rotate originalImg to angle 270
					copy dimensions of originalImg to {W, H}
					set the new_W to (H * sizex) / sizey
					set crop_dimensions to {new_W, H}
				else
					set the new_H to (W * sizey) / sizex
					set crop_dimensions to {W, new_H}
				end if
				
			end if
			
			crop originalImg to dimensions crop_dimensions
			
			set the new_image to save originalImg as PNG in file filePath with icon
			close originalImg
		end tell
	on error error_message
		display dialog error_message
	end try
end createLaunchImage
