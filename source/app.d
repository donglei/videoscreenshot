import std.stdio;
import std.format;
import std.process;
import std.string;

void main()
{
	auto start = 0;
	auto input_file="myvideo.mp4";
	auto size = "320x240";
	auto output_file = "output_file1.jpg";
	string rotate = getRotate(input_file);
	string transpose= "";
	switch(rotate)
	{
			break;
		case "90":
			transpose = q{-vf "transpose=1"};
			break;
		case "180":
			transpose = q{-vf "transpose=2,transpose=2"};
			break;
		case "270":
			transpose = q{-vf "transpose=2"};
			break;
		default :
			transpose = "";
	}
	writeln("transpose:", transpose);
	//command ffmpeg -ss 1  -i myvideo.mp4 -frames 1 -s 320x240 -vf "transpose=1"  3323-r190-1.jpg
	//"rotate=%s"
	string command = format(q{ffmpeg -v "error" -ss %s  -i %s -frames 1 -s %s %s -y %s},
								start,
							input_file,
							size,
							transpose,
							output_file
							);
	writeln(command);
	auto ls = executeShell(command);
	if (ls.status != 0) 
		writeln("Failed to snapshot");
	else 
		writeln(ls.output);
}

string getRotate(string video)
{
	//command  ffprobe -show_streams 20150916141050.mp4  2>/dev/null | grep rotate  
	string command = format(q{ffprobe -show_streams %s  2>/dev/null | grep rotate},
								video
							);
	writeln(command);
	auto ls = executeShell(command);
	if (ls.status != 0) 
		return "0";
	else 
		writeln(ls.output);
	if(ls.output.indexOf("rotate=") != -1)
	{
		import std.regex;
		auto c = matchFirst(ls.output, regex(`rotate\s*=\s*(?P<rotate>\d+)`));
		if(!c.empty)
		{
			writeln("matched ", c["rotate"]);
			return c["rotate"]; 
		}
	}
	return "0";
}