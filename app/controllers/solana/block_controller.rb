module Solana
  class BlockController < NetworkController
    layout 'tabs'

    before_action :set_block_id
    before_action :breadcrumb

    def show; end

    def transactions; end

    def transfers; end

    private

    def set_block_id
      @block_id = params[:block_id]
    end

    def breadcrumb
      @breadcrumbs << { name: "#{t("tabs.#{controller_name}.show.name")}: #{@block_id.truncate(15)}",
                        url: "#{locale_path_prefix}#{@network[:network]}/block/#{@block_id}" }

      return if action_name == 'show'

      @breadcrumbs << { name: "#{t("tabs.#{controller_name}.#{action_name}.name")}" }
    end
  end
end

