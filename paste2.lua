local toggles = {
    force_head = true,
    fake_crouch = true,
    force_ground = true
}

local old_force = hookfunction(getrenv()._G.modules.Character.IsGrounded, function(...)
    if toggles.force_ground then
        return true
    end
    return old_force(...)
end)

    local old_hooks = hookfunction(game.Players.LocalPlayer:FindFirstChild("RemoteEvent").FireServer, function(self, ...)
        local args = {...}

        if args[1] == 10 and typeof(args[4]) == "Vector3" and toggles.force_head then
            args[6] = "Head"
        end

        if args[1] == 2  and toggles.force_crouch then
            args[2] = true
        end

        return old_hooks(self, unpack(args))
    end)
