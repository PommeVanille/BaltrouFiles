


-- je renomme ce fichier en jokers.lua, vu que y'a que ca dedans, comme ca on s'organise si un jour on fait des tarot, skip.blind ou comme ca 
    -- pour l'idée de la pool de joker "homies" jsp si on fait ca ici ou si on fais un autre dossier, on verra quand on connaitras comment le faire i guess 



SMODS.Atlas{
    key = 'Jokers',
    path = 'Jokers.png',
    px = 71,
    py = 91,
}


SMODS.Joker {
    key = 'Joker1',
    loc_txt = {
        name = 'joker de merde',
        text = {'adds {C:mult}+1{} Mult'}

    },

    atlas = 'Jokers',
    pos = {x = 0, y = 0},
   
    config = {mult = 1},
    calculate = function(self, card, context)
        if context.joker_main then
            
            return {
                mult = card.ability.mult
            }
        end
    end

}


SMODS.Joker {
    key = 'Joker2',
    loc_txt = {
        name = 'Wheel of Miuel',
        text = {'when blind skipped > {C:green}1/4{} chance to get a random {C:dark_edition}negative joker{}'},
    },
        rarity = 3,

        atlas = 'Jokers',
        pos = {x = 1, y = 0},

 calculate = function(self, card, context)
        if context.skip_blind then
            local randomOneToFour = math.random(4)
            
            if randomOneToFour == 1 then
                local new_card = create_card('Joker', G.jokers, nil, nil, nil, nil)
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                new_card:set_edition({negative = true}, true)

                         else
                attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
             
            end

        end
    end

}

-- Joker de ellie : debuff x jokers to its left, retrigger the joker to its right x times 

