package main

import (
	"fmt"
	"os"

	"gocv.io/x/gocv"
)

func main() {
	if len(os.Args) < 2 {
		fmt.Println("Please specify the path to the GLTF file")
		return
	}

	filePath := os.Args[1]
	window := gocv.NewWindow("GLTF Viewer")
	defer window.Close()

	// Load the GLTF file
	gltf, err := gocv.Open3DModel(filePath)
	if err != nil {
		fmt.Println(err)
		return
	}
	defer gltf.Close()

	// Set up the camera intrinsics
	intrinsics := gocv.GetDefaultIntrinsics()
	intrinsics.Center.X = float64(gltf.GetWidth()) / 2
	intrinsics.Center.Y = float64(gltf.GetHeight()) / 2

	// Set the initial camera pose
	pose := gocv.NewMat()
	defer pose.Close()
	gltf.GetViewPose(pose)

	// Loop until the user closes the window
	for {
		// Render the GLTF model
		img := gocv.NewMat()
		defer img.Close()
		gltf.Render(intrinsics, pose, &img)

		// Display the rendered image
		window.IMShow(img)
		if window.WaitKey(1) >= 0 {
			break
		}
	}
}
