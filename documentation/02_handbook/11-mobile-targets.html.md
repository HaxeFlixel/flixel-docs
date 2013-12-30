```
title: "Mobile Targets"
```

With the penetration of mobile devices in the world ignoring mobile targets for your games and applications is ignoring a huge audience.

Mobile devices even though amazing have particular bottlenecks not present on desktop targets. The bottleneck most significant to HaxeFlixel games is the low powered cpu. HaxeFlixel's answer to this is to make use of gpu acceleration provided by OpenFL.

#### CPU

The processing power of mobile cpus are often the biggest bottleneck when compared to a desktop target. Mobile cpus are constrained by low power architectures and are simply not as powerful. Manipulating pixels like bitmap filters do with Flash software rendering is simply too slow for mobile devices. HaxeFlixel has answered this for Flixel games to use the GPU for rendering your sprites instead of using software rendering like its done with Flash.

#### Memory

Memory on mobile devices as you can imagine does not compare to the desktop. When we talk about memory it relates to how many textures your game can store to render as well as the amount of raw data and objects in your game's runtime state. Memory lets you cache objects for quick runtime access instead of creating objects during your gameplay which may cause skipping and low performance. This is why HaxeFlixel uses destroy method and has implemented support for texture atlas'.

#### Texture Size Limits

Due to the nature of mobile hardware there are often maximum sizes for textures that are much lower than desktop hardware. There is no definitive guide to size limits as it depends on the hardware of each device individually.

Here you can see an overview of size limits obtained from webgl browsers [http://webglstats.com/#h_texsize](http://webglstats.com/#h_texsize)

You can also look up a device on [glxbench.com](http://glxbench.com), under the GL config tab look for GL_MAX_TEXTURE_SIZE.

Here is an overview of the variety in devices, feel free to add to the list;

<table border="1" cellpadding="1" cellspacing="1" class="table table-hover table-bordered">
	<tbody>
	</tbody>
	<thead>
		<tr>
			<td>**Device**</td>
			<td>**Processor**</td>
			<td>**Max Texture Size**</td>
			<td>**Display Resolution**</td>
			<td>**Memory**</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>

iPhone

			</td>
			<td>

Armv6

			</td>
			<td>

1024x1024

			</td>
			<td>

480x320

			</td>
			<td>

128MB

			</td>
		</tr>
		<tr>
			<td>

iPhone 3G

			</td>
			<td>

Armv6

			</td>
			<td>

1024x1024

			</td>
			<td>

480x320

			</td>
			<td>

128MB

			</td>
		</tr>
		<tr>
			<td>

iPhone 3GS

			</td>
			<td>

Cortex-A8

			</td>
			<td>

2048x2048

			</td>
			<td>

480x320

			</td>
			<td>

256MB

			</td>
		</tr>
		<tr>
			<td>

iPhone 4

			</td>
			<td>

Cortex-A8

			</td>
			<td>

2048x2048

			</td>
			<td>

960x640

			</td>
			<td>

512MB

			</td>
		</tr>
		<tr>
			<td>

iPhone 4S

			</td>
			<td>

Cortex-A9 Dual-Core

			</td>
			<td>

4096x4096

			</td>
			<td>

960x640

			</td>
			<td>

512MB

			</td>
		</tr>
		<tr>
			<td>

iPad

			</td>
			<td>

Cortex-A8

			</td>
			<td>

2048x2048

			</td>
			<td>

1024x768

			</td>
			<td>

512MB

			</td>
		</tr>
		<tr>
			<td>

iPad 2

			</td>
			<td>

Cortex-A9 Dual-Core

			</td>
			<td>

2048x2048

4096x4096 (iOS 5.1)

			</td>
			<td>

1024x768

			</td>
			<td>

512MB

			</td>
		</tr>
		<tr>
			<td>iPad 3</td>
			<td>Cortex-A9 Dual-Core</td>
			<td>4096x4096</td>
			<td>2048x1536</td>
			<td>1024MB</td>
		</tr>
	</tbody>
</table>