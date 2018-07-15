<?php

$finder = PhpCsFixer\Finder::create()
    ->exclude('vendor')
    ->notPath('src/Symfony/Component/Translation/Tests/fixtures/resources.php')
    ->in(__DIR__)
;

return PhpCsFixer\Config::create()
    ->setRiskyAllowed(true)
    ->setRules(array(
        '@PSR2' => true,
        'strict_param' => true,
        'array_syntax' => array('syntax' => 'long'),
    ))
    ->setFinder($finder)
;
