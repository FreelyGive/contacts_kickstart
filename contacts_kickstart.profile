<?php

/**
 * @file
 * Main profile file for the Contacts Kickstart distribution.
 */

use Drupal\Core\Form\FormStateInterface;

/**
 * Implements hook_form_FORM_ID_alter() for install_configure_form().
 *
 * Allows the profile to alter the site configuration form.
 */
function contacts_kickstart_form_install_configure_form_alter(&$form, FormStateInterface $form_state) {
  // Add 'Contacts Kickstart' fieldset and options.
  $form['contacts_kickstart'] = [
    '#type' => 'fieldgroup',
    '#title' => t('Contacts Kickstart optional configuration'),
    '#description' => t('All the required modules and configuration will be automatically installed and imported. You can optionally select generated demo content.'),
    '#weight' => 50,
  ];

  // Checkboxes to generate demo content.
  $form['contacts_kickstart']['demo_content'] = [
    '#type' => 'checkbox',
    '#title' => t('Generate demo content and users'),
    '#default_value' => TRUE,
    '#description' => t('Will generate files, contacts and organisations.'),
  ];

  // Submit handler to enable features.
  $form['#submit'][] = 'contacts_kickstart_demo_content_submit';
}

/**
 * Submit handler.
 */
function contacts_kickstart_demo_content_submit($form, &$form_state) {
  if ($form_state->getValue('demo_content') === 1) {
    set_time_limit(0);
    \Drupal::service('module_installer')->install(['contacts_demo']);
  }
}
