module CotesHelper

  def cotes_pilotes(event)
    values = {}

    if event.present?
      if event.numero == 1
        # Handle the specific case of the event with numero == 1
        association_users = pilotes_division(event.division)

        association_users.each do |association_user|
          association_user_id = association_user.id
          user_id = association_user.user.id

          coteBase = 1.0 # Set a fixed base cote value for the first event

          victoire = (coteBase * 3.41).round(2)
          pole = (coteBase * 3.08).round(2)
          podium = (coteBase * 2.07).round(2)
          top10 = (coteBase * 1.09).round(2)

          values[user_id] = { association_user_id: association_user_id, user_id: user_id, victoire: victoire, pole: pole, podium: podium, top10: top10 }
        end
      else
        ranked_users = somme_user(event)
        maxScore = ranked_users.first[:score] > 0 ? ranked_users.first[:score] : 1

        ranked_users.each do |user|
          association_user_id = user[:association_user_id]
          user_id = user[:user_id]
          rank = user[:rank]
          score = user[:score]

          deltaPoints = (maxScore - score) / maxScore
          coteBase = 1 + ((0.14 * rank) + (0.87 * deltaPoints))

          victoire = (coteBase * 3.41).round(2)
          pole = (coteBase * 3.08).round(2)
          podium = (coteBase * 2.07).round(2)
          top10 = (coteBase * 1.09).round(2)

          values[user_id] = { association_user_id: association_user_id, user_id: user_id, score: score, victoire: victoire, pole: pole, podium: podium, top10: top10 }
        end
      end
    end

    values
  end

end
