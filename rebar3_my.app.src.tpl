{application, {{ name }},
 [{description, "{{ name }} Application"},
  {vsn, "1.0"},
  {registered, []},
  {mod, { {{ name }}_app, []}},
  {applications,
   [kernel,
    stdlib,
    sasl
   ]},
  {env,[]},
  {modules, []},

  {maintainers, []},
  {licenses, ["Apache 2.0"]},
  {links, []}
 ]}.

