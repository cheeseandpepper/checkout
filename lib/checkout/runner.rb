#!/usr/bin/env ruby

module Checkout
  class Runner
    attr_accessor :max, :branches, :branch_choice_object, :selection, :branch

    def initialize(max)
      get_max(max)
      run!
    end

    def run!
      ask_for_selection
      map_selection_to_branch
      checkout
    end

    private

    def get_max(val)
      if val.nil?
        @max ||= 10
      else
        @max = val.to_i
      end
    end

    def ask_for_selection
      puts 'Choose a branch...'
      puts ''
      display_branches
      @selection ||= STDIN.gets.chomp
    end

    def map_selection_to_branch
      @branch ||= branch_choice_object[selection.to_i]
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
