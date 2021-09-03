examplemodifier = examplemodifier or class({})

function examplemodifier:GetTexture() return "examplemodifier" end -- get the icon from a different ability

function examplemodifier:IsPermanent() return true end
function examplemodifier:RemoveOnDeath() return false end
function examplemodifier:IsHidden() return self:GetParent():GetHealthPercent() > 10 end 	-- we can hide the modifier
function examplemodifier:IsDebuff() return false end 	-- make it red or green

function examplemodifier:OnCreated()
	self.damage_reduction = 0
	self:StartIntervalThink(0.1)
end

function examplemodifier:GetAttributes()
	return 0
		+ MODIFIER_ATTRIBUTE_PERMANENT           -- Modifier passively remains until strictly removed. 
end

function examplemodifier:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_AVOID_DAMAGE
	}
end

function examplemodifier:GetModifierAvoidDamage(kv)
	if IsClient() then return end
	
	local avoid_chance = math.min(90, (1 - (self:GetParent():GetHealth())/self:GetParent():GetMaxHealth()) * 100 )

	if RollPercentage(avoid_chance) then
		if self:GetParent():IsHero() then
			self:GetParent():EmitSound("dodge")
		end
		return 1
	end

	return 0
end