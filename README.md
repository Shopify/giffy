# Giffy

Giffy is a very simple tool to use. The goal was to make it simple to take a screencast/demo
and convert it into a gif without needing to remember all the incantations required for ffmpeg
and ImageMagick

## Prerequisites

You'll need to have `ffmpeg` and `imagemagick` installed on your system

```
# Mac OSX & Homebrew
brew install ffmpeg imagemagick

# Debian/Ubuntu
sudo apt-get install ffmpeg imagemagick

# Arch Linux
pacman -S ffmpeg imagemagick
```

## Installation

If you want to use the command line tool simply:

    $ gem install giffy

If you want to use custom extensions or use giffy in
a project add the following to your applications Gemfile:

    gem 'giffy'

And then execute:

    $ bundle

## Usage

From your terminal simply type the following:

    $ giffy path_to_your_video path_to_where_gif_should_go

## Contributing

Don't forget to include tests. Contributions without tests may not be
accepted as quickly.

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
