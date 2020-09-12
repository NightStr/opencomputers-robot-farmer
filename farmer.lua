robot = require("robot")
component = require("component")
geolyzer = component.geolyzer
turn = {robot.turnLeft, robot.turnRight}
LOOP_COUNT = 5

function turn(lo)
    if ((lo - 1) % 2) == 0 then
        robot.turnLeft()
    else
        robot.turnRight()
    end
end

function unloading()
    for slot = 1, robot.inventorySize() do
        robot.select(slot)
        robot.drop()
    end
end

function process_row()
    while true do
        robot.forward()
        block = geolyzer.analyze(0)
        if block["hardness"] > 0 then
            break
        end
        if block["growth"] and block["growth"] == 1 then
            robot.swingDown()
        end
    end
end

while true do
    for i = 0, 1 do
        robot.turnAround()
        for l = 1, LOOP_COUNT do
            process_row()
            if l ~= LOOP_COUNT then
                turn(l)
                robot.forward()
                turn(l)
            end
        end
    end
    unloading()
end
