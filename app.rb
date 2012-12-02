#!/usr/bin/env ruby

require 'paint'
require 'terminal-table'
require 'rest-client'
require 'json'
require 'uri'
require 'trollop'


def makeResource(route)
    route = URI.escape(route)
    return RestClient::Resource.new @endpoint + '/' + route + '/api/json', @username, @password
end


def getJobs()
    resource = makeResource('/')
    return JSON.parse(resource.get)['jobs']
end

def getJob(name)
    resource = makeResource('job/' + name)
    return JSON.parse(resource.get)
end

def list()
    jobs = getJobs()

    rows = []
    jobs.each do |job|
        rows << [job['name'], getJobStatus(job["name"])]
    end

    header = ['Job', {:value => 'Status', :alignment => :center}]
    table = Terminal::Table.new :headings => header, :rows => rows
    table.align_column(1, :center)
    print table
end

def getJobStatus(name, prefix = "", suffix = "")
    score = getJob(name)['healthReport']
    unless score == []
        score = score[0]['score']

        if score > 80
            return Paint[score.to_s + '%', :black, :green, :bright]
        elsif score > 60 && score < 80
            return Paint[score.to_s + '%', :yellow, :bright]
        elsif score > 40 && score < 60
            return Paint[score.to_s + '%', :orange, :bright]
        elsif score > 20 && score < 40
            return Paint[score.to_s + '%', :orange, :bright, :red]
        elsif score < 20
            return Paint[score.to_s + '%', :white, :bright, :red]
        else
            return Paint["Error", :white, :bright, :red]
        end

    end

    return Paint["No Results", :white, :bright, :black]
end


opts = Trollop::options do
    version "Leeroy 0.0.1 (c) 2012 John Hamelink <john@johnhamelink.com>"
    banner <<-EOS

    Leeeeeeeeeeeeeeeeroy Jenkins!

    Leeroy lets you quickly check the status of your builds from the commandline.
    Leeroy is called Leeroy because of this excellent meme: http://youtu.be/LkCNJRfSZBU

    Usage:
    ------

    leeroy --username john@doe.com --password p455w0rd --endpoint http://jenkins.dev:8080

    Options:
    --------

    EOS
    opt :username, "Your Jenkins username", :type => :string
    opt :password, "Your Jenkins password", :type => :string
    opt :endpoint, "The root URL of jenkins", :type => :string
end


Trollop::die :username, "must be defined" unless opts[:username]
Trollop::die :password, "must be defined" unless opts[:password]
Trollop::die :endpoint, "must be defined" unless opts[:endpoint]


@username = opts[:username]
@password = opts[:password]
@endpoint = opts[:endpoint]


print "\n\n"
list()
print "\n\n"
