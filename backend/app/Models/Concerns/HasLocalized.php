<?php

namespace App\Models\Concerns;

trait HasLocalized
{
    /**
     * Returns "{field}_{locale}", falling back to Arabic when the
     * translation is missing or empty.
     */
    public function localized(string $field, ?string $locale = null): ?string
    {
        $locale = $locale ?? app()->getLocale();
        $value = $this->getAttribute("{$field}_{$locale}");

        if ($value === null || $value === '') {
            return $this->getAttribute("{$field}_ar");
        }

        return $value;
    }
}
