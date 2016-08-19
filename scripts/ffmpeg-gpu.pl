#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;

my %params = (
  fps => 25,
  threads => 1,
  bitrate => '6000000',
);

$params{output} = pop @ARGV;

while(my $param = shift(@ARGV))
{
  for ($param)
  {
    if (/-framerate/)
    {
      $params{fps} = shift(@ARGV);
    }

    if (/-i/)
    {
      $params{input} = shift(@ARGV);
    }

    if (/-threads/)
    {
      $params{threads} = shift(@ARGV);
    }

    if (/-r/)
    {
      $params{r} = shift(@ARGV);
    }

    if (/-b/)
    {
      $params{bitrate} = shift(@ARGV);
    }

    if (/-vf/)
    {
      $params{filter} = shift(@ARGV);
    }
  }
}

my @cmd = ('gst-launch-1.0','multifilesrc',"location=$params{input}","index=0","caps=\"image/jpeg,framerate=$params{fps}/1\"","!","jpegdec","!","omxh264enc","!","h264parse","!","mp4mux","!","filesink","location=$params{output}");

exec @cmd;
