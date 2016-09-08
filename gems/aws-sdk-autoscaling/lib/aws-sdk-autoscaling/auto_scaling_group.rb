# WARNING ABOUT GENERATED CODE
#
# The AWS SDK for Ruby is largely generated from JSON service definitions. Edits
# made against this file will be lost the next time the SDK updates.  To resolve
# an issue with generated code, a change is likely needed in the generator or
# in one of the service JSON definitions.
#
# * https://github.com/aws/aws-sdk-ruby/tree/master/gems/aws-sdk-code-generator
# * https://github.com/aws/aws-sdk-ruby/tree/master/apis
#
# Open a GitHub issue if you have questions before making changes.  Pull
# requests against this file will be automatically closed.
#
# WARNING ABOUT GENERATED CODE
module Aws
  module AutoScaling
    class AutoScalingGroup

      extend Aws::Deprecations

      # @overload def initialize(name, options = {})
      #   @param [String] name
      #   @option options [Client] :client
      # @overload def initialize(options = {})
      #   @option options [required, String] :name
      #   @option options [Client] :client
      def initialize(*args)
        options = Hash === args.last ? args.pop.dup : {}
        @name = extract_name(args, options)
        @data = options.delete(:data)
        @client = options.delete(:client) || Client.new(options)
      end

      # @!group Read-Only Attributes

      # @return [String]
      def name
        @name
      end
      alias :auto_scaling_group_name :name

      # The Amazon Resource Name (ARN) of the group.
      # @return [String]
      def auto_scaling_group_arn
        data.auto_scaling_group_arn
      end

      # The name of the associated launch configuration.
      # @return [String]
      def launch_configuration_name
        data.launch_configuration_name
      end

      # The minimum size of the group.
      # @return [Integer]
      def min_size
        data.min_size
      end

      # The maximum size of the group.
      # @return [Integer]
      def max_size
        data.max_size
      end

      # The desired size of the group.
      # @return [Integer]
      def desired_capacity
        data.desired_capacity
      end

      # The amount of time, in seconds, after a scaling activity completes
      # before another scaling activity can start.
      # @return [Integer]
      def default_cooldown
        data.default_cooldown
      end

      # One or more Availability Zones for the group.
      # @return [Array<String>]
      def availability_zones
        data.availability_zones
      end

      # One or more load balancers associated with the group.
      # @return [Array<String>]
      def load_balancer_names
        data.load_balancer_names
      end

      # The Amazon Resource Names (ARN) of the target groups for your load
      # balancer.
      # @return [Array<String>]
      def target_group_arns
        data.target_group_arns
      end

      # The service to use for the health checks. The valid values are `EC2`
      # and `ELB`.
      # @return [String]
      def health_check_type
        data.health_check_type
      end

      # The amount of time, in seconds, that Auto Scaling waits before
      # checking the health status of an EC2 instance that has come into
      # service.
      # @return [Integer]
      def health_check_grace_period
        data.health_check_grace_period
      end

      # The date and time the group was created.
      # @return [Time]
      def created_time
        data.created_time
      end

      # The suspended processes associated with the group.
      # @return [Array<Types::SuspendedProcess>]
      def suspended_processes
        data.suspended_processes
      end

      # The name of the placement group into which you\'ll launch your
      # instances, if any. For more information, see [Placement Groups][1] in
      # the *Amazon Elastic Compute Cloud User Guide*.
      #
      #
      #
      # [1]: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html
      # @return [String]
      def placement_group
        data.placement_group
      end

      # One or more subnet IDs, if applicable, separated by commas.
      #
      # If you specify `VPCZoneIdentifier` and `AvailabilityZones`, ensure
      # that the Availability Zones of the subnets match the values for
      # `AvailabilityZones`.
      # @return [String]
      def vpc_zone_identifier
        data.vpc_zone_identifier
      end

      # The metrics enabled for the group.
      # @return [Array<Types::EnabledMetric>]
      def enabled_metrics
        data.enabled_metrics
      end

      # The current state of the group when DeleteAutoScalingGroup is in
      # progress.
      # @return [String]
      def status
        data.status
      end

      # The termination policies for the group.
      # @return [Array<String>]
      def termination_policies
        data.termination_policies
      end

      # Indicates whether newly launched instances are protected from
      # termination by Auto Scaling when scaling in.
      # @return [Boolean]
      def new_instances_protected_from_scale_in
        data.new_instances_protected_from_scale_in
      end

      # @!endgroup

      # @return [Client]
      def client
        @client
      end

      # Loads, or reloads {#data} for the current {AutoScalingGroup}.
      # Returns `self` making it possible to chain methods.
      #
      #     auto_scaling_group.reload.data
      #
      # @return [self]
      def load
        resp = @client.describe_auto_scaling_groups(auto_scaling_group_names: [@name])
        @data = resp.autoscalinggroups[0]
        self
      end
      alias :reload :load

      # @return [Types::AutoScalingGroup]
      #   Returns the data for this {AutoScalingGroup}. Calls
      #   {Client#describe_auto_scaling_groups} if {#data_loaded?} is `false`.
      def data
        load unless @data
        @data
      end

      # @return [Boolean]
      #   Returns `true` if this resource is loaded.  Accessing attributes or
      #   {#data} on an unloaded resource will trigger a call to {#load}.
      def data_loaded?
        !!@data
      end

      # @return [Boolean]
      #   Returns `true` if the AutoScalingGroup exists.
      def exists?
        begin
          wait_until_exists(max_attempts: 1)
          true
        rescue Aws::Waiters::Errors::UnexpectedError => e
          raise e.error
        rescue Aws::Waiters::Errors::WaiterFailed
          false
        end
      end

      # @param options ({})
      # @option options [Integer] :max_attempts (10)
      # @option options [Float] :delay (5)
      # @option options [Proc] :before_attempt
      # @option options [Proc] :before_wait
      # @return [AutoScalingGroup]
      def wait_until_exists(options = {})
        waiter = Waiters::GroupExists.new(options.merge(client: @client))
        yield_waiter_and_warn(waiter, &Proc.new) if block_given?
        waiter.wait(auto_scaling_group_names: [@name])
        AutoScalingGroup.new({
          name: @name,
          client: @client
        })
      end

      # @param options ({})
      # @option options [Integer] :max_attempts (40)
      # @option options [Float] :delay (15)
      # @option options [Proc] :before_attempt
      # @option options [Proc] :before_wait
      # @return [AutoScalingGroup]
      def wait_until_in_service(options = {})
        waiter = Waiters::GroupInService.new(options.merge(client: @client))
        yield_waiter_and_warn(waiter, &Proc.new) if block_given?
        waiter.wait(auto_scaling_group_names: [@name])
        AutoScalingGroup.new({
          name: @name,
          client: @client
        })
      end

      # @param options ({})
      # @option options [Integer] :max_attempts (40)
      # @option options [Float] :delay (15)
      # @option options [Proc] :before_attempt
      # @option options [Proc] :before_wait
      # @return [AutoScalingGroup]
      def wait_until_not_exists(options = {})
        waiter = Waiters::GroupNotExists.new(options.merge(client: @client))
        yield_waiter_and_warn(waiter, &Proc.new) if block_given?
        waiter.wait(auto_scaling_group_names: [@name])
        AutoScalingGroup.new({
          name: @name,
          client: @client
        })
      end

      # @!group Actions

      # @param [Hash] options ({})
      # @option options [Array<String>] :instance_ids
      #   One or more instance IDs.
      # @return [EmptyStructure]
      def attach_instances(options = {})
        options = options.merge(auto_scaling_group_name: @name)
        resp = @client.attach_instances(options)
        resp.data
      end

      # @param [Hash] options ({})
      # @option options [Boolean] :force_delete
      #   Specifies that the group will be deleted along with all instances
      #   associated with the group, without waiting for all instances to be
      #   terminated. This parameter also deletes any lifecycle actions
      #   associated with the group.
      # @return [EmptyStructure]
      def delete(options = {})
        options = options.merge(auto_scaling_group_name: @name)
        resp = @client.delete_auto_scaling_group(options)
        resp.data
      end

      # @param [Hash] options ({})
      # @option options [Array<String>] :instance_ids
      #   One or more instance IDs.
      # @option options [required, Boolean] :should_decrement_desired_capacity
      #   If `True`, the Auto Scaling group decrements the desired capacity
      #   value by the number of instances detached.
      # @return [Activity::Collection]
      def detach_instances(options = {})
        batch = []
        options = options.merge(auto_scaling_group_name: @name)
        resp = @client.detach_instances(options)
        resp.data.activities.each do |a|
          batch << Activity.new(
            id: a.activity_id,
            data: a,
            client: @client
          )
        end
        Activity::Collection.new([batch], size: batch.size)
      end

      # @param [Hash] options ({})
      # @option options [Array<String>] :metrics
      #   One or more of the following metrics. If you omit this parameter, all
      #   metrics are disabled.
      #
      #   * `GroupMinSize`
      #
      #   * `GroupMaxSize`
      #
      #   * `GroupDesiredCapacity`
      #
      #   * `GroupInServiceInstances`
      #
      #   * `GroupPendingInstances`
      #
      #   * `GroupStandbyInstances`
      #
      #   * `GroupTerminatingInstances`
      #
      #   * `GroupTotalInstances`
      # @return [EmptyStructure]
      def disable_metrics_collection(options = {})
        options = options.merge(auto_scaling_group_name: @name)
        resp = @client.disable_metrics_collection(options)
        resp.data
      end

      # @param [Hash] options ({})
      # @option options [Array<String>] :metrics
      #   One or more of the following metrics. If you omit this parameter, all
      #   metrics are enabled.
      #
      #   * `GroupMinSize`
      #
      #   * `GroupMaxSize`
      #
      #   * `GroupDesiredCapacity`
      #
      #   * `GroupInServiceInstances`
      #
      #   * `GroupPendingInstances`
      #
      #   * `GroupStandbyInstances`
      #
      #   * `GroupTerminatingInstances`
      #
      #   * `GroupTotalInstances`
      # @option options [required, String] :granularity
      #   The granularity to associate with the metrics to collect. The only
      #   valid value is `1Minute`.
      # @return [EmptyStructure]
      def enable_metrics_collection(options = {})
        options = options.merge(auto_scaling_group_name: @name)
        resp = @client.enable_metrics_collection(options)
        resp.data
      end

      # @param [Hash] options ({})
      # @option options [required, String] :policy_name
      #   The name of the policy.
      # @option options [String] :policy_type
      #   The policy type. Valid values are `SimpleScaling` and `StepScaling`.
      #   If the policy type is null, the value is treated as `SimpleScaling`.
      # @option options [required, String] :adjustment_type
      #   The adjustment type. Valid values are `ChangeInCapacity`,
      #   `ExactCapacity`, and `PercentChangeInCapacity`.
      #
      #   For more information, see [Dynamic Scaling][1] in the *Auto Scaling
      #   User Guide*.
      #
      #
      #
      #   [1]: http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/as-scale-based-on-demand.html
      # @option options [Integer] :min_adjustment_step
      #   Available for backward compatibility. Use `MinAdjustmentMagnitude`
      #   instead.
      # @option options [Integer] :min_adjustment_magnitude
      #   The minimum number of instances to scale. If the value of
      #   `AdjustmentType` is `PercentChangeInCapacity`, the scaling policy
      #   changes the `DesiredCapacity` of the Auto Scaling group by at least
      #   this many instances. Otherwise, the error is `ValidationError`.
      # @option options [Integer] :scaling_adjustment
      #   The amount by which to scale, based on the specified adjustment type.
      #   A positive value adds to the current capacity while a negative number
      #   removes from the current capacity.
      #
      #   This parameter is required if the policy type is `SimpleScaling` and
      #   not supported otherwise.
      # @option options [Integer] :cooldown
      #   The amount of time, in seconds, after a scaling activity completes and
      #   before the next scaling activity can start. If this parameter is not
      #   specified, the default cooldown period for the group applies.
      #
      #   This parameter is not supported unless the policy type is
      #   `SimpleScaling`.
      #
      #   For more information, see [Auto Scaling Cooldowns][1] in the *Auto
      #   Scaling User Guide*.
      #
      #
      #
      #   [1]: http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/Cooldown.html
      # @option options [String] :metric_aggregation_type
      #   The aggregation type for the CloudWatch metrics. Valid values are
      #   `Minimum`, `Maximum`, and `Average`. If the aggregation type is null,
      #   the value is treated as `Average`.
      #
      #   This parameter is not supported if the policy type is `SimpleScaling`.
      # @option options [Array<Types::StepAdjustment>] :step_adjustments
      #   A set of adjustments that enable you to scale based on the size of the
      #   alarm breach.
      #
      #   This parameter is required if the policy type is `StepScaling` and not
      #   supported otherwise.
      # @option options [Integer] :estimated_instance_warmup
      #   The estimated time, in seconds, until a newly launched instance can
      #   contribute to the CloudWatch metrics. The default is to use the value
      #   specified for the default cooldown period for the group.
      #
      #   This parameter is not supported if the policy type is `SimpleScaling`.
      # @return [ScalingPolicy]
      def put_scaling_policy(options = {})
        options = options.merge(auto_scaling_group_name: @name)
        resp = @client.put_scaling_policy(options)
        ScalingPolicy.new(
          name: options[:policy_name],
          client: @client
        )
      end

      # @param [Hash] options ({})
      # @option options [required, String] :scheduled_action_name
      #   The name of this scaling action.
      # @option options [Time,DateTime,Date,Integer,String] :time
      #   This parameter is deprecated.
      # @option options [Time,DateTime,Date,Integer,String] :start_time
      #   The time for this action to start, in \"YYYY-MM-DDThh:mm:ssZ\" format
      #   in UTC/GMT only (for example, `2014-06-01T00:00:00Z`).
      #
      #   If you try to schedule your action in the past, Auto Scaling returns
      #   an error message.
      #
      #   When `StartTime` and `EndTime` are specified with `Recurrence`, they
      #   form the boundaries of when the recurring action starts and stops.
      # @option options [Time,DateTime,Date,Integer,String] :end_time
      #   The time for this action to end.
      # @option options [String] :recurrence
      #   The time when recurring future actions will start. Start time is
      #   specified by the user following the Unix cron syntax format. For more
      #   information, see [Cron][1] in Wikipedia.
      #
      #   When `StartTime` and `EndTime` are specified with `Recurrence`, they
      #   form the boundaries of when the recurring action will start and stop.
      #
      #
      #
      #   [1]: http://en.wikipedia.org/wiki/Cron
      # @option options [Integer] :min_size
      #   The minimum size for the Auto Scaling group.
      # @option options [Integer] :max_size
      #   The maximum size for the Auto Scaling group.
      # @option options [Integer] :desired_capacity
      #   The number of EC2 instances that should be running in the group.
      # @return [ScheduledAction]
      def put_scheduled_update_group_action(options = {})
        options = options.merge(auto_scaling_group_name: @name)
        resp = @client.put_scheduled_update_group_action(options)
        ScheduledAction.new(
          name: options[:scheduled_action_name],
          client: @client
        )
      end

      # @param [Hash] options ({})
      # @option options [Array<String>] :scaling_processes
      #   One or more of the following processes. If you omit this parameter,
      #   all processes are specified.
      #
      #   * `Launch`
      #
      #   * `Terminate`
      #
      #   * `HealthCheck`
      #
      #   * `ReplaceUnhealthy`
      #
      #   * `AZRebalance`
      #
      #   * `AlarmNotification`
      #
      #   * `ScheduledActions`
      #
      #   * `AddToLoadBalancer`
      # @return [EmptyStructure]
      def resume_processes(options = {})
        options = options.merge(auto_scaling_group_name: @name)
        resp = @client.resume_processes(options)
        resp.data
      end

      # @param [Hash] options ({})
      # @option options [required, Integer] :desired_capacity
      #   The number of EC2 instances that should be running in the Auto Scaling
      #   group.
      # @option options [Boolean] :honor_cooldown
      #   By default, `SetDesiredCapacity` overrides any cooldown period
      #   associated with the Auto Scaling group. Specify `True` to make Auto
      #   Scaling to wait for the cool-down period associated with the Auto
      #   Scaling group to complete before initiating a scaling activity to set
      #   your Auto Scaling group to its new capacity.
      # @return [EmptyStructure]
      def set_desired_capacity(options = {})
        options = options.merge(auto_scaling_group_name: @name)
        resp = @client.set_desired_capacity(options)
        resp.data
      end

      # @param [Hash] options ({})
      # @option options [Array<String>] :scaling_processes
      #   One or more of the following processes. If you omit this parameter,
      #   all processes are specified.
      #
      #   * `Launch`
      #
      #   * `Terminate`
      #
      #   * `HealthCheck`
      #
      #   * `ReplaceUnhealthy`
      #
      #   * `AZRebalance`
      #
      #   * `AlarmNotification`
      #
      #   * `ScheduledActions`
      #
      #   * `AddToLoadBalancer`
      # @return [EmptyStructure]
      def suspend_processes(options = {})
        options = options.merge(auto_scaling_group_name: @name)
        resp = @client.suspend_processes(options)
        resp.data
      end

      # @param [Hash] options ({})
      # @option options [String] :launch_configuration_name
      #   The name of the launch configuration.
      # @option options [Integer] :min_size
      #   The minimum size of the Auto Scaling group.
      # @option options [Integer] :max_size
      #   The maximum size of the Auto Scaling group.
      # @option options [Integer] :desired_capacity
      #   The number of EC2 instances that should be running in the Auto Scaling
      #   group. This number must be greater than or equal to the minimum size
      #   of the group and less than or equal to the maximum size of the group.
      # @option options [Integer] :default_cooldown
      #   The amount of time, in seconds, after a scaling activity completes
      #   before another scaling activity can start. The default is 300.
      #
      #   For more information, see [Auto Scaling Cooldowns][1] in the *Auto
      #   Scaling User Guide*.
      #
      #
      #
      #   [1]: http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/Cooldown.html
      # @option options [Array<String>] :availability_zones
      #   One or more Availability Zones for the group.
      # @option options [String] :health_check_type
      #   The service to use for the health checks. The valid values are `EC2`
      #   and `ELB`.
      # @option options [Integer] :health_check_grace_period
      #   The amount of time, in seconds, that Auto Scaling waits before
      #   checking the health status of an EC2 instance that has come into
      #   service. The default is 0.
      #
      #   For more information, see [Health Checks][1] in the *Auto Scaling User
      #   Guide*.
      #
      #
      #
      #   [1]: http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/healthcheck.html
      # @option options [String] :placement_group
      #   The name of the placement group into which you\'ll launch your
      #   instances, if any. For more information, see [Placement Groups][1] in
      #   the *Amazon Elastic Compute Cloud User Guide*.
      #
      #
      #
      #   [1]: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html
      # @option options [String] :vpc_zone_identifier
      #   The ID of the subnet, if you are launching into a VPC. You can specify
      #   several subnets in a comma-separated list.
      #
      #   When you specify `VPCZoneIdentifier` with `AvailabilityZones`, ensure
      #   that the subnets\' Availability Zones match the values you specify for
      #   `AvailabilityZones`.
      #
      #   For more information, see [Launching Auto Scaling Instances in a
      #   VPC][1] in the *Auto Scaling User Guide*.
      #
      #
      #
      #   [1]: http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/asg-in-vpc.html
      # @option options [Array<String>] :termination_policies
      #   A standalone termination policy or a list of termination policies used
      #   to select the instance to terminate. The policies are executed in the
      #   order that they are listed.
      #
      #   For more information, see [Controlling Which Instances Auto Scaling
      #   Terminates During Scale In][1] in the *Auto Scaling User Guide*.
      #
      #
      #
      #   [1]: http://docs.aws.amazon.com/AutoScaling/latest/DeveloperGuide/AutoScalingBehavior.InstanceTermination.html
      # @option options [Boolean] :new_instances_protected_from_scale_in
      #   Indicates whether newly launched instances are protected from
      #   termination by Auto Scaling when scaling in.
      # @return [AutoScalingGroup]
      def update(options = {})
        options = options.merge(auto_scaling_group_name: @name)
        resp = @client.update_auto_scaling_group(options)
        AutoScalingGroup.new(
          name: options[:auto_scaling_group_name],
          client: @client
        )
      end

      # @!group Associations

      # @param [Hash] options ({})
      # @option options [Array<String>] :activity_ids
      #   The activity IDs of the desired scaling activities. If you omit this
      #   parameter, all activities for the past six weeks are described. If you
      #   specify an Auto Scaling group, the results are limited to that group.
      #   The list of requested activities cannot contain more than 50 items. If
      #   unknown activities are requested, they are ignored with no error.
      # @return [Activity::Collection]
      def activities(options = {})
        batches = Enumerator.new do |y|
          options = options.merge(auto_scaling_group_name: @name)
          resp = @client.describe_scaling_activities(options)
          resp.each_page do |page|
            batch = []
            page.data.activities.each do |a|
              batch << Activity.new(
                id: a.activity_id,
                data: a,
                client: @client
              )
            end
            y.yield(batch)
          end
        end
        Activity::Collection.new(batches)
      end

      # @return [Instance::Collection]
      def instances
        batch = []
        data.instances.each do |i|
          batch << Instance.new(
            group_name: @name,
            id: i.instance_id,
            data: i,
            client: @client
          )
        end
        Instance::Collection.new([batch], size: batch.size)
      end

      # @return [LaunchConfiguration, nil]
      def launch_configuration
        if data.launch_configuration_name
          LaunchConfiguration.new(
            name: data.launch_configuration_name,
            client: @client
          )
        else
          nil
        end
      end

      # @param [String] name
      # @return [LifecycleHook]
      def lifecycle_hook(name)
        LifecycleHook.new(
          group_name: @name,
          name: name,
          client: @client
        )
      end

      # @param [Hash] options ({})
      # @option options [Array<String>] :lifecycle_hook_names
      #   The names of one or more lifecycle hooks. If you omit this parameter,
      #   all lifecycle hooks are described.
      # @return [LifecycleHook::Collection]
      def lifecycle_hooks(options = {})
        batches = Enumerator.new do |y|
          batch = []
          options = options.merge(auto_scaling_group_name: @name)
          resp = @client.describe_lifecycle_hooks(options)
          resp.data.lifecycle_hooks.each do |l|
            batch << LifecycleHook.new(
              group_name: l.auto_scaling_group_name,
              name: l.lifecycle_hook_name,
              data: l,
              client: @client
            )
          end
          y.yield(batch)
        end
        LifecycleHook::Collection.new(batches)
      end

      # @param [String] name
      # @return [LoadBalancer]
      def load_balancer(name)
        LoadBalancer.new(
          group_name: @name,
          name: name,
          client: @client
        )
      end

      # @param [Hash] options ({})
      # @option options [String] :next_token
      #   The token for the next set of items to return. (You received this
      #   token from a previous call.)
      # @option options [Integer] :max_records
      #   The maximum number of items to return with this call.
      # @return [LoadBalancer::Collection]
      def load_balancers(options = {})
        batches = Enumerator.new do |y|
          batch = []
          options = options.merge(auto_scaling_group_name: @name)
          resp = @client.describe_load_balancers(options)
          resp.data.load_balancers.each do |l|
            batch << LoadBalancer.new(
              group_name: @name,
              name: l.load_balancer_name,
              data: l,
              client: @client
            )
          end
          y.yield(batch)
        end
        LoadBalancer::Collection.new(batches)
      end

      # @param [Hash] options ({})
      # @return [NotificationConfiguration::Collection]
      def notification_configurations(options = {})
        batches = Enumerator.new do |y|
          options = Aws::Util.deep_merge(options, auto_scaling_group_names: [@name])
          resp = @client.describe_notification_configurations(options)
          resp.each_page do |page|
            batch = []
            page.data.notification_configurations.each do |n|
              batch << NotificationConfiguration.new(
                group_name: n.auto_scaling_group_name,
                type: n.notification_type,
                topic_arn: n.topic_arn,
                data: n,
                client: @client
              )
            end
            y.yield(batch)
          end
        end
        NotificationConfiguration::Collection.new(batches)
      end

      # @param [Hash] options ({})
      # @option options [Array<String>] :policy_names
      #   One or more policy names or policy ARNs to be described. If you omit
      #   this parameter, all policy names are described. If an group name is
      #   provided, the results are limited to that group. This list is limited
      #   to 50 items. If you specify an unknown policy name, it is ignored with
      #   no error.
      # @option options [Array<String>] :policy_types
      #   One or more policy types. Valid values are `SimpleScaling` and
      #   `StepScaling`.
      # @return [ScalingPolicy::Collection]
      def policies(options = {})
        batches = Enumerator.new do |y|
          options = options.merge(auto_scaling_group_name: @name)
          resp = @client.describe_policies(options)
          resp.each_page do |page|
            batch = []
            page.data.scaling_policies.each do |s|
              batch << ScalingPolicy.new(
                name: s.policy_name,
                data: s,
                client: @client
              )
            end
            y.yield(batch)
          end
        end
        ScalingPolicy::Collection.new(batches)
      end

      # @param [Hash] options ({})
      # @option options [Array<String>] :scheduled_action_names
      #   Describes one or more scheduled actions. If you omit this parameter,
      #   all scheduled actions are described. If you specify an unknown
      #   scheduled action, it is ignored with no error.
      #
      #   You can describe up to a maximum of 50 instances with a single call.
      #   If there are more items to return, the call returns a token. To get
      #   the next set of items, repeat the call with the returned token.
      # @option options [Time,DateTime,Date,Integer,String] :start_time
      #   The earliest scheduled start time to return. If scheduled action names
      #   are provided, this parameter is ignored.
      # @option options [Time,DateTime,Date,Integer,String] :end_time
      #   The latest scheduled start time to return. If scheduled action names
      #   are provided, this parameter is ignored.
      # @return [ScheduledAction::Collection]
      def scheduled_actions(options = {})
        batches = Enumerator.new do |y|
          options = options.merge(auto_scaling_group_name: @name)
          resp = @client.describe_scheduled_actions(options)
          resp.each_page do |page|
            batch = []
            page.data.scheduled_update_group_actions.each do |s|
              batch << ScheduledAction.new(
                name: s.scheduled_action_name,
                data: s,
                client: @client
              )
            end
            y.yield(batch)
          end
        end
        ScheduledAction::Collection.new(batches)
      end

      # @param [String] key
      # @return [Tag]
      def tag(key)
        Tag.new(
          key: key,
          resource_id: @name,
          resource_type: "auto-scaling-group",
          client: @client
        )
      end

      # @return [Tag::Collection]
      def tags
        batch = []
        data.tags.each do |t|
          batch << Tag.new(
            key: t.key,
            resource_id: t.resource_id,
            resource_type: t.resource_type,
            client: @client
          )
        end
        Tag::Collection.new([batch], size: batch.size)
      end

      # @deprecated
      # @api private
      def identifiers
        { name: @name }
      end
      deprecated(:identifiers)

      private

      def extract_name(args, options)
        value = args[0] || options.delete(:name)
        case value
        when String then value
        when nil then raise ArgumentError, "missing required option :name"
        else
          msg = "expected :name to be a String, got #{value.class}"
          raise ArgumentError, msg
        end
      end

      def yield_waiter_and_warn(waiter, &block)
        if !@waiter_block_warned
          msg = "pass options to configure the waiter; "
          msg << "yielding the waiter is deprecated"
          warn(msg)
          @waiter_block_warned = true
        end
        yield(waiter.waiter)
      end

      class Collection

        include Aws::Resources::Collection

        # @return [Enumerator<AutoScalingGroup>]
        def each(&block)
          enum = super
          enum.each(&block) if block
          enum
        end

      end
    end
  end
end
