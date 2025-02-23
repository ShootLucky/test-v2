-- esp.lua
local function enableESP()
    print("ESP Box Ativado")
    -- Adicione aqui a lógica para desenhar as caixas (boxes) ao redor dos jogadores.
end

local function disableESP()
    print("ESP Box Desativado")
    -- Adicione aqui a lógica para remover as caixas (boxes) ao redor dos jogadores.
end

local function enableSkeleton()
    print("ESP Skeleton Ativado")
    -- Adicione aqui a lógica para desenhar o esqueleto dos jogadores.
end

local function disableSkeleton()
    print("ESP Skeleton Desativado")
    -- Adicione aqui a lógica para remover o esqueleto dos jogadores.
end

local function enableHealth()
    print("ESP Health Ativado")
    -- Adicione aqui a lógica para exibir a vida dos jogadores.
end

local function disableHealth()
    print("ESP Health Desativado")
    -- Adicione aqui a lógica para remover a exibição da vida dos jogadores.
end

return {
    enableESP = enableESP,
    disableESP = disableESP,
    enableSkeleton = enableSkeleton,
    disableSkeleton = disableSkeleton,
    enableHealth = enableHealth,
    disableHealth = disableHealth
}
