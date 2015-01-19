class CounterCacheObserver

  def increment_counter_cache(subject, association, column_name)
    subject.send(association).increment!(column_name)
  end

  def decrement_counter_cache(subject, association, column_name)
    subject.send(association).decrement!(column_name)
  end

  def reset_counter_cache(subject, association, column_name)
    subject.send(association).update_column(column, subject.send(:association).count)
  end

end