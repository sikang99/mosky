#
# Makefile for mosky gltf streaming
#
#------------------------------------------------------------------------------------------
BUILD=0.0.0.1
#------------------------------------------------------------------------------------------
usage:
	@echo "usage: make [build|run|kill|ffmpeg]"
#------------------------------------------------------------------------------------------
edit e:
	@echo "> make (edit) [readme|history|srt]"
edit-readme er:
	vi README.md
edit-history eh:
	vi HISTORY.md
edit-srt es:
	vi SRT.md
#------------------------------------------------------------------------------------------
build b:
	@echo "> make (build) [all|client|server]"
build-all ba:
	cd server; make build
	cd client; make build
build-server bs:
	cd server; make build
build-client bc:
	cd client; make build
#------------------------------------------------------------------------------------------
run r:
	@echo "> make (run) [client|server]"
run-server rs:
	server/culex -addr ":6001" 
run-client rc:
	client/srt-client

build-run-server brs:
	@make build-server
	@make run-server
#------------------------------------------------------------------------------------------
kill k: 
	@echo "> make (kill) [all|client|server|ffmpeg]"
kill-all ka:
	pkill srt-server
	pkill srt-client
	pkill ffmpeg ffplay
kill-server ks:
	pkill srt-server
kill-client kc:
	pkill srt-client
kill-ffmpeg kf:
	pkill ffmpeg ffplay
#------------------------------------------------------------------------------------------
open o:
	open https://github.com/datarhei/gosrt
	#open https://github.com/openfresh/gosrt
clean:
	rm -f client/srt-client server/culex
#------------------------------------------------------------------------------------------
ffmpeg ffplay f:
	@echo "> make (ffmpeg) [file|cast|play]"
ffmpeg-file ff:
	ffmpeg -re -i $(HOME)/assets/videos/NVIDIA-RTX.mp4 \
		-flags low_delay -c:v libx264 \
		-f mpegts -transtype live \
		"srt://127.0.0.1:6001?streamid=publish:/live/stream"

ffmpeg-cast fc:
	ffmpeg -f avfoundation -framerate 30 -video_size 1280x720 -i "0:none" \
		-codec:v libx264 -b:v 1024k -maxrate:v 1024k -bufsize:v 1024k -preset ultrafast -tune zerolatency -r 25 -g 50 \
		-pix_fmt yuv420p -vsync 1 -flags2 local_header -f mpegts -transtype live \
		"srt://127.0.0.1:6001?streamid=publish:/live/stream"

ffplay-play fp:
	ffplay \
		-fflags nobuffer -flags low_delay -framedrop \
		-f mpegts -transtype live \
		-i "srt://127.0.0.1:6001?streamid=/live/stream"

ffmpeg-test ft:
	ffmpeg -f avfoundation -r 30 -i "1" -frames:v 1 capture.jpg

#OBS: [Server] srt://127.0.0.1:6001?streamid=publish:/live/stream
#------------------------------------------------------------------------------------------
git g:
	@echo "make (git:g) [update|store]"
git-reset gr:
	git reset --soft HEAD~1
git-update gu:
	git add .
	git commit -a -m "$(BUILD),$(USER)"
	git push
git-store gs:
	git config credential.helper store
#------------------------------------------------------------------------------------------

