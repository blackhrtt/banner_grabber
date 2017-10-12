require 'violent_ruby' # For the banner grabber.
require 'trollop'      # For clean option parsing.
require 'colorize'     # For beautiful colors.
require 'logoris'      # Log to the right standard stream.

logger = Logoris.new
application_name = 'Bannner Grabber made by Bl4ck_H34rTT'

# Default to a help menu if no argument is given.
ARGV[0] = '-h' if ARGV.empty?

# Option parsing.
opts = Trollop::options do
  banner  "#{application_name}".red
  version "#{application_name} CLI 1.0.0 (c) 2017 Bl4ck_H34rTT "
  opt :ips,     "Target IP address(es) to use", type: :strings
  opt :ports,   "Target port(s) to use",        type: :ints
  opt :Verbose, "Verbose output option",        type: :bool, default: false
end

ViolentRuby::BannerGrabber.new(ips: opts[:ips], ports: opts[:ports]).grab do |result|
  if result[:open]
    logger.out("OPEN".green + " -- " + "#{result[:ip].bold}:#{result[:port]}" + " -- " + "#{result[:banner].strip.yellow}")
  else
    logger.error("CLOSED".red + " -- " + "#{result[:ip].bold}:#{result[:port]}") if opts[:Verbose]
  end
end
