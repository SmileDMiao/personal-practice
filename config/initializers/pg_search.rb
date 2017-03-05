PgSearch.multisearch_options = {
    :using => {
        tsearch: {
            # dictionary: 'zhcnsearch',
            :prefix => true,
            :highlight => {
                :start_sel => '<em>',
                :stop_sel => '</em>'
            }
        }
    }
}