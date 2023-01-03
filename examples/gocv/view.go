package main

import (
	"log"

	"gocv.io/x/gocv"
)

func main() {
	// Open the glTF file.
	modelFile := "duck.gltf"
	model := gocv.IMRead(modelFile, gocv.IMReadColor)
	if model.Empty() {
		log.Println("open error:", modelFile)
		return
	}
	defer model.Close()

	// Create a window to display the model.
	window := gocv.NewWindow("Model")
	defer window.Close()

	// Loop until the window is closed.
	for {
		// Show the model in the window.
		window.IMShow(model)
		if window.WaitKey(1) >= 0 {
			break
		}
	}
}
