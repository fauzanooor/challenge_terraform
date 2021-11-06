resource "aws_launch_template" "buburtimor_lt" {
    name_prefix   = "bbrtmr_lt_${var.env}"
    image_id      = var.image_id
    instance_type = var.instance_type
    key_name      = var.key_name
    
    
    tag_specifications {
        resource_type = "instance"
        
        tags = {
            Name = "bbrtmr_${var.env}"
        }
    }
}

resource "aws_autoscaling_group" "buburtimor_asg" {
    name               = "bbrtmr_asg_${var.env}"
    desired_capacity   = var.desired_capacity
    max_size           = var.max_size
    min_size           = var.min_size
    vpc_zone_identifier = var.vpc_subnet_id

    launch_template {
        id      = aws_launch_template.buburtimor_lt.id
        version = "$Latest"
    }
}

resource "aws_autoscaling_policy" "buburtimor_asg_policy_cpu" {
    name                   = var.asg_policy_name
    policy_type            = "TargetTrackingScaling"
    autoscaling_group_name = aws_autoscaling_group.buburtimor_asg.name

    target_tracking_configuration {
        predefined_metric_specification {
            predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = var.cpu_trigger_value
    }
}