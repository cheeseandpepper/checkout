#!/usr/bin/env ruby

module Checkout
  class Runner
    attr_accessor :max, :branches, :branch_choice_object, :selection, :branch

    def initialize(max)
      if max.nil?
        puts "max is 10"
        @max ||= 10
      else
        puts "max is #{max}"
        @max ||= max.to_i
      end
      run!
    end

    def run!
      puts "asking"
      ask_for_selection
      puts 'mapping selection'
      map_selection_to_branch
      puts 'checking out'
      checkout
    end

    private

    def ask_for_selection
      puts 'Choose a branch...'
      puts ''
      display_branches
      @selection ||= STDIN.gets.chomp
    end

    def map_selection_to_branch
      puts "selection is #{selection}"
      @branch ||= branch_choice_object[selection.to_i]
      puts "branch is #{@branch}"
      puts "branch choice object is #{branch_choice_object}"
    end

    def branches
      @branches ||= `git for-each-ref --sort=-committerdate refs/heads/`
                      .split(/\n/)
                      .map { |b| b.match(/heads\//).post_match }
    end

    def branch_choice_object
      limit = (max > branches.size) ? branches.size : max
      @branch_choice_object ||= Hash[(0...limit).zip(branches)]
    end

    def display_branches
      branch_choice_object.each do |k, v|
        puts "k is #{k}"
        puts "v is #{v}"
        puts "k dot size is #{k.to_s.size}"
        puts "branch is #{branch}"
        dashes = "-" * (5 - k.to_s.size)
        puts "#{k.to_s.colorize(:yellow)} #{dashes} #{v.colorize(:green)}"
      end
    end

    def checkout
      puts "Now checking out #{branch}"
      `git checkout #{branch}`
    end

  end
end
