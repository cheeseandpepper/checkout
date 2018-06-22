#!/usr/bin/env ruby

module Checkout
  class Runner
    attr_reader :max, :branches, :branch_choice_object, :selection, :branch

    def initialize(max=10)
      @max ||= max
      run!
    end

    def run!
      ask_for_selection
      map_selection_to_branch
      checkout
    end

    private

    def ask_for_selection
      puts 'Choose a branch...'
      puts ''
      puts branch_choice_object
      @selection ||= gets.chomp
    end

    def map_selection_to_branch
      @branch ||= branch_choice_object[selection]
    end

    def branches
      @branches ||= `git for-each-ref --sort=-committerdate refs/heads/`
                      .split(/\n/)
                      .map { |branch| branch.match(/heads\//).post_match }
    end

    def branch_choice_object
      @branch_choice_object ||= Hash[(0...branches.size).zip(branches)]
    end

    def checkout
      `git checkout #{branch}`
    end

  end
end
