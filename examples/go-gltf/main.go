package main

import (
	"fmt"
	"io/ioutil"

	"github.com/go-gltf/gltf"
)

func main() {
	// Read the .glb file into a byte slice.
	data, err := ioutil.ReadFile("model.glb")
	if err != nil {
		panic(err)
	}

	// Parse the byte slice into a glTF model.
	model := gltf.Model{}
	if err := model.UnmarshalBinary(data); err != nil {
		panic(err)
	}

	// Access the model data.
	fmt.Println(model.Asset.Generator)
	fmt.Println(len(model.Meshes))
	fmt.Println(len(model.Materials))
	fmt.Println(len(model.Animations))
}

