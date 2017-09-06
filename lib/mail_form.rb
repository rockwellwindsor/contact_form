module MailForm
  # autoload allows us to lazy load a constant when it is first referenced
  autoload :Base,       'mail_form/base'
  autoload :Notifier,   'mail_form/notifier'
  autoload :Validators, 'mail_form/validators'
end
