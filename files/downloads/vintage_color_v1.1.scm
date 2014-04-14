; Vintage Color Effect script for GIMP
; Version 1.1
; Based on : http://gimpology.com/submission/view/authentic_vintage_effect


(define (vintage-color-effect image drawable)
  (if (gimp-item-is-layer drawable)
	(let* 
	  ((vintage-layer (car (gimp-layer-copy drawable 0))))

	  (begin
		(gimp-image-undo-group-start image)

		; add the duplicated layer
		(gimp-image-insert-layer image vintage-layer (car (gimp-item-get-parent drawable)) (car (gimp-image-get-item-position image drawable)))

		; apply hue-saturation settings
		(gimp-hue-saturation vintage-layer 0 -11 0 21)

		; apply the red curve
		(gimp-curves-spline vintage-layer HISTOGRAM-RED 8 #(0 0 107 145 195 255 255 255))

		; apply the green curve
		(gimp-curves-spline vintage-layer HISTOGRAM-GREEN 8 #(0 0 99 124 186 204 255 255))

		; apply the blue curve
		(gimp-curves-spline vintage-layer HISTOGRAM-BLUE 4 #(0 40 255 203))
		;
		; apply hue-saturation settings
		(gimp-hue-saturation vintage-layer 0 -9 9 -32)

		; flush display
		(gimp-displays-flush)

		(gimp-image-undo-group-end image)
		)
	  )
	(gimp-message "The active drawable must be a layer")
	)
  )


(script-fu-register
  "vintage-color-effect" ;function
  "Vintage photo effect" ;menu label
  "Applies a series of effect to the current layer in order to\
  reproduce a vintage effect. The steps are taken from this site:\
  http://gimpology.com/submission/view/authentic_vintage_effect" ;description
  "Jozef Legény" ;author
  "copyright 2011, Jozef Legény" ;copyright notice			
  "April 15, 2011" ;date created
  ""
  SF-IMAGE "Image" 0
  SF-DRAWABLE "Drawable" 0
  )

(script-fu-menu-register "vintage-color-effect" "<Image>/Colors/")
