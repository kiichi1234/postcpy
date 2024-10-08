module ApplicationHelper
    def category_in_japanese(category)
      {
        'physical aspect' => '身体面',
        'mental aspect' => '精神面',
        'life aspect' => '生活面',
        'other' => 'その他'
      }[category]
    end
end
