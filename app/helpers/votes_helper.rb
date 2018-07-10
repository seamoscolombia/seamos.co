module VotesHelper
  def vote_percentage(quantity, total_votes)
    return 0 unless quantity      
    "%g" % ("%.1f" % ((quantity.to_i * 100)/total_votes.to_f) )
  end

  def vote_count(poll)
    res = {}
    poll.votes.group_by(&:vote_type).each do |key, value|
      res[key.name] = value.size
    end
    res
  end
end