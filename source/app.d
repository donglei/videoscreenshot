import std.stdio;
import std.format;
import std.process;

void main()
{
	auto start = 0;
	auto input_file="myvideo.mp4";
	auto size = "320x240";
	auto output_file = "output_file1.jpg";
	//command ffmpeg -ss 1  -i myvideo.mp4 -frames 1 -s 320x240 -vf "transpose=1"  3323-r190-1.jpg
	string command = format(q{ffmpeg -v "error" -ss %s  -i %s -frames 1 -s %s -vf "transpose=1" -y %s},
								start,
							input_file,
							size,
							output_file
							);
	writeln(command);
	auto ls = executeShell(command);
	if (ls.status != 0) 
		writeln("Failed to snapshot");
	else 
		writeln(ls.output);
}
