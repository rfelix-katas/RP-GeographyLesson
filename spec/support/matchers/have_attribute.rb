module AttributeMatchers
  
  Spec::Matchers.define :have_attribute do |name|
    match do |target|
      getter = name.to_sym
      setter = (name.to_s + "=").to_sym
      target.respond_to?(getter) && target.respond_to?(setter)
    end
  end
  
end