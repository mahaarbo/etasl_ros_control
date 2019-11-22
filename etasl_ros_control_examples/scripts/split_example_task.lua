-- Copyright (c) 2019 Norwegian University of Science and Technology
-- Use of this source code is governed by the LGPL-3.0 license, see LICENSE

require("geometric")

tgt_y = ctx:createInputChannelScalar("tgt_y")
tgt_z = ctx:createInputChannelScalar("tgt_z")

d = Variable{context = ctx, name = "d", vartype = "feature"}

Constraint{
    context = ctx,
    name = "laserdistance",
    expr = d,
    target_lower = 0.5,
    target_upper = 0.9,
    K = 4
}

laserspot = robot_ee * vector(0, 0, d)

Constraint{
    context = ctx,
    name = "x",
    expr = tgt_x - coord_x(laserspot),
    priority = 2,
    K = 4
}
Constraint{
    context = ctx,
    name = "y",
    expr = tgt_y - coord_y(laserspot),
    priority = 2,
    K = 4
}
Constraint{
    context = ctx,
    name = "z",
    expr = tgt_z - coord_z(laserspot),
    priority = 2,
    K = 4
}

ctx:setOutputExpression("error_x", coord_x(laserspot) - tgt_x)
ctx:setOutputExpression("error_y", coord_y(laserspot) - tgt_y)
ctx:setOutputExpression("error_z", coord_z(laserspot) - tgt_z)
ctx:setOutputExpression("laser", laserspot)
